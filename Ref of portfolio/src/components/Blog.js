import React from 'react';
import { motion } from 'framer-motion';
import { FaArrowRight, FaClock } from 'react-icons/fa';

const ARTICLES = [
  { title:'Deploying Dual NGINX Servers on AWS EC2 with Docker', date:'September 2025', readTime:'8 min read', desc:'A deep dive into container isolation, volume mounting, and static content serving using Docker on an EC2 instance.', tag:'DevOps',   link:'https://www.linkedin.com/in/farmanullah-ansari', color:'#7c3aed' },
  { title:'The Future of Cashless Bartering in Pakistan',        date:'March 2026',     readTime:'6 min read', desc:'How we built Gadd Kaam using the MERN stack to digitise traditional skill swapping and combat economic inflation.', tag:'MERN Stack',link:'https://www.linkedin.com/in/farmanullah-ansari', color:'#e040fb' },
];

const Blog = () => (
  <section className="blog" id="blog">
    <motion.h2 initial={{ opacity:0, y:-20 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }}>
      Insights &amp; Articles
    </motion.h2>
    <div className="blog-grid">
      {ARTICLES.map((a, i) => (
        <motion.div className="blog-card" key={i}
          style={{ '--blog-color': a.color }}
          initial={{ opacity:0, y:30 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }}
          transition={{ delay:i*.15, duration:.5 }} whileHover={{ y:-9 }}>
          <div className="blog-tag">{a.tag}</div>
          <h3 className="blog-title">{a.title}</h3>
          <p className="blog-desc">{a.desc}</p>
          <div className="blog-footer">
            <div className="blog-meta">
              <span className="blog-date">{a.date}</span>
              <span className="blog-read-time"><FaClock /> {a.readTime}</span>
            </div>
            <a href={a.link} target="_blank" rel="noreferrer" className="blog-read-link">
              Read More <FaArrowRight />
            </a>
          </div>
        </motion.div>
      ))}
    </div>
  </section>
);
export default Blog;