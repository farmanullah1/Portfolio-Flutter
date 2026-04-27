import React from 'react';
import { motion } from 'framer-motion';
import { 
  HiOutlineSupport, HiOutlineLightningBolt, HiOutlineRefresh, 
  HiOutlineShieldCheck, HiOutlineDeviceMobile, HiOutlineChatAlt2 
} from 'react-icons/hi';
import { FaRocket, FaBullseye } from 'react-icons/fa';

const FEATURES = [
  {
    icon: <HiOutlineSupport />,
    title: '24/7 Support',
    desc: 'Available round the clock for any development needs. Your project gets the attention it deserves, any time of day.',
    color: '#e040fb',
    tag: 'Reliable',
  },
  {
    icon: <HiOutlineLightningBolt />,
    title: 'Fast & Reliable',
    desc: 'Delivering high-performance web solutions with speed and precision — efficiency without compromising quality.',
    color: '#7c3aed',
    tag: 'Efficient',
  },
  {
    icon: <HiOutlineRefresh />,
    title: 'Adaptable',
    desc: 'Adapting seamlessly to unique project requirements. From startups to enterprises, solutions tailored to fit any scope.',
    color: '#00e5ff',
    tag: 'Flexible',
  },
  {
    icon: <HiOutlineShieldCheck />,
    title: 'Security-First',
    desc: 'Security baked in from day one — JWT auth, CNIC verification, data encryption, and secure REST APIs.',
    color: '#f59e0b',
    tag: 'Secure',
  },
  {
    icon: <HiOutlineDeviceMobile />,
    title: 'Fully Responsive',
    desc: 'Every interface is crafted to look and work flawlessly across all devices — mobile, tablet, and desktop.',
    color: '#00e676',
    tag: 'Cross-Device',
  },
  {
    icon: <FaRocket />,
    title: 'Cloud-Native Scale',
    desc: 'Architecture designed to grow with your product. AWS, Docker, CI/CD pipelines — built for real-world scale.',
    color: '#40c4ff',
    tag: 'Scalable',
  },
  {
    icon: <FaBullseye />,
    title: 'Deadline-Driven',
    desc: 'I treat deadlines as commitments, not suggestions. Projects are delivered on time, tested, and ready to ship.',
    color: '#ff4081',
    tag: 'Punctual',
  },
  {
    icon: <HiOutlineChatAlt2 />,
    title: 'Open Communication',
    desc: 'Transparent updates, regular check-ins, and honest feedback throughout the entire project lifecycle.',
    color: '#ffab40',
    tag: 'Collaborative',
  },
];

const containerVariants = {
  hidden: {},
  show: { transition: { staggerChildren: 0.07, delayChildren: 0.1 } },
};

const cardVariants = {
  hidden: { opacity: 0, y: 30 },
  show: { opacity: 1, y: 0, transition: { duration: 0.48, ease: [0.4, 0, 0.2, 1] } },
};

const WhyMe = () => (
  <section className="why-me" id="why-me">
    <motion.h2 initial={{ opacity: 0, y: -20 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }}>
      Why Work With Me?
    </motion.h2>

    <motion.p
      className="why-me-subtitle"
      initial={{ opacity: 0, y: 10 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ delay: 0.1 }}
    >
      I bring more than just code — I bring commitment, craftsmanship, and a genuine passion for building things that matter.
    </motion.p>

    <motion.div
      className="features-grid"
      variants={containerVariants}
      initial="hidden"
      whileInView="show"
      viewport={{ once: true, margin: '-60px' }}
    >
      {FEATURES.map((item, i) => (
        <motion.div
          className="feature-card"
          key={i}
          variants={cardVariants}
          whileHover={{ y: -8, scale: 1.025 }}
          style={{ '--feature-color': item.color }}
        >
          {/* Corner glow handled in CSS */}
          <div className="feature-tag" style={{ color: item.color, background: `${item.color}14`, borderColor: `${item.color}44` }}>
            {item.tag}
          </div>
          <div className="feature-icon-wrap">
            <span className="feature-icon" style={{ color: item.color }} aria-label={item.title}>{item.icon}</span>
          </div>
          <h3>{item.title}</h3>
          <p>{item.desc}</p>
          <div className="feature-accent-line" />
        </motion.div>
      ))}
    </motion.div>
  </section>
);

export default WhyMe;